report 50457 "Update Student Course Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Student Course Units.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = Programme = FIELD("Programme Code"),
                               Unit = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    IF "ACA-Student Units".Units = 0 THEN BEGIN
                        "ACA-Student Units".Units := "ACA-Units/Subjects"."No. Units";
                        "ACA-Student Units".MODIFY;
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

