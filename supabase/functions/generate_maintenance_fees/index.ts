import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL") ?? "",
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
  );

  const startTime = Date.now();
  let status = 'success';
  let errorMsg = null;
  let responseData = null;
  let rowCount = 0;

  try {
    // 1. Calculate Dates
    const now = new Date();
    const fromDate = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), 1));
    const toDate = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth() + 1, 0, 23, 59, 59));
    
    const dueDate = new Date(fromDate);
    dueDate.setUTCDate(fromDate.getUTCDate() + 10);

    const fromDateIso = fromDate.toISOString();

    // 2. Fetch existing fees for this specific month to prevent duplicates
    const { data: existingFees, error: existingError } = await supabase
      .from("maintenance_fees")
      .select("property_id")
      .eq("from_date", fromDateIso);

    if (existingError) throw existingError;

    // Create a Set of property IDs that already have fees for faster lookup
    const existingPropertyIds = new Set(existingFees?.map(f => f.property_id));

    // 3. Fetch properties with contracts
    const { data: properties, error: propError } = await supabase
      .from("properties")
      .select(`
        id,
        community_id,
        contract_id,
        contracts ( amount_in_cents )
      `)
      .not("contract_id", "is", null);

    if (propError) throw propError;

    // 4. Filter properties that DON'T have a fee yet for this month
    const newProperties = properties.filter(prop => !existingPropertyIds.has(prop.id));

    // 5. Prepare bulk insert
    const feesToInsert = newProperties.map((prop) => ({
      community_id: prop.community_id,
      contract_id: prop.contract_id,
      property_id: prop.id,
      amount_in_cents: prop.contracts.amount_in_cents,
      from_date: fromDateIso,
      to_date: toDate.toISOString(),
      due_date: dueDate.toISOString(),
      note: `Automated Fee: ${now.toLocaleString('default', { month: 'long' })} ${now.getFullYear()}`,
    }));

    rowCount = feesToInsert.length;

    // 6. Insert into maintenance_fees
    if (rowCount > 0) {
      const { error: insertError } = await supabase
        .from("maintenance_fees")
        .insert(feesToInsert);
      if (insertError) throw insertError;
    }

    responseData = { 
      message: `Checked ${properties.length} properties. Generated ${rowCount} new fees.`,
      skipped: properties.length - rowCount
    };
    
    return new Response(JSON.stringify(responseData), {
      headers: { "Content-Type": "application/json" },
      status: 200,
    });

  } catch (error) {
    status = 'error';
    errorMsg = error.message;
    return new Response(JSON.stringify({ error: errorMsg }), {
      headers: { "Content-Type": "application/json" },
      status: 500,
    });
  } finally {
    // 7. Always log the outcome
    await supabase.from('edge_function_logs').insert({
      function_name: 'generate_maintenance_fees',
      status: status,
      execution_time_ms: Date.now() - startTime,
      payload: { new_records: rowCount }, 
      response: responseData,
      error_message: errorMsg
    });
  }
});