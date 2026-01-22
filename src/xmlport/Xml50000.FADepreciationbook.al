xmlport 50000 "FA Depreciation book"
{
    Caption = 'Import Fa Dep Book';
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(FAD; "FA Depreciation Book")
            {
                fieldattribute(No; FAD."FA No.")
                {

                }
                fieldattribute(bk; FAD."Depreciation Book Code")
                {

                }
                fieldattribute(pg; FAD."FA Posting Group")
                {

                }
                fieldattribute(Method; FAD."Depreciation Method")
                {

                }
                fieldattribute(date; FAD."Depreciation Starting Date")
                {

                }
                fieldattribute(stp; FAD."Straight-Line %")
                {

                }
            }
        }
    }
}