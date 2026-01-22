report 50190 PopulateSageOrger
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; "ACA-Programme")
        {
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);

                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                    "ACA-Programme Stages".Order := seq;
                    "ACA-Programme Stages".MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(seq);
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
        seq: Integer;
}

