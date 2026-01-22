xmlport 50001 "Import Assets"
{
    Caption = 'Import Assets';
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(Asset; "Fixed Asset")
            {
                fieldattribute(No; Asset."No.")
                {

                }
                fieldattribute(description; Asset.Description)
                {

                }
                fieldattribute(Tag; Asset."Tag No")
                {
                    Occurrence = Optional;
                }
                fieldattribute(Code; Asset."Asset Code")
                {
                    Occurrence = Optional;
                }
                fieldattribute(serial; Asset."Serial No.")
                {
                    Occurrence = Optional;
                }
                fieldattribute(location; Asset."Location Code")
                {
                    Occurrence = Optional;
                }
                fieldattribute(class; Asset."FA Class Code")
                {

                }
                fieldattribute(SubClass; Asset."FA Subclass Code")
                {

                }
                fieldattribute(Nos; Asset."Asset Nos")
                {
                    Occurrence = Optional;
                }

            }
        }
    }
}