report 50438 "Validate  Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; "ACA-Student Units")
        {
            RequestFilterFields = Programme, Semester, Unit;

            trigger OnAfterGetRecord()
            begin
                //"ACA-Lecturers Units".VALIDATE("ACA-Lecturers Units".Programme);
                reg.VALIDATE(Unit);
                reg.MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('done');
            end;
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
    var
        reg: Record "ACA-Student Units";
}

