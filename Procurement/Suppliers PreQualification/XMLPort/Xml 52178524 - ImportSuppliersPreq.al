xmlport 52178524 "Import Suppliers Preq"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(Preq; "Proc-Preq. Suppliers/Category")
            {
                AutoUpdate = true;
                fieldattribute(PreqYear; Preq."Preq. Year")
                {
                }
                fieldattribute(PreqCategory; Preq."Preq. Category")
                {
                }
                fieldattribute(Supplier_Code; Preq.Supplier_Code)
                {
                }
            }
        }
    }
}