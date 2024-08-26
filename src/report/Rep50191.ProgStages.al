report 50191 ProgStages
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(AP; "ACA-Programme")
        {

            trigger OnAfterGetRecord()
            begin
                buff.RESET;
                IF buff.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        Progstages.INIT;
                        Progstages."Programme Code" := AP.Code;
                        Progstages.Code := buff.Code;
                        Progstages.Description := buff.Desc;
                        Progstages.INSERT();
                    END;
                    UNTIL buff.NEXT = 0;
                END;
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

    trigger OnPreReport()
    begin
        Progstages.RESET;
        IF Progstages.FIND('-') THEN BEGIN
            Progstages.DELETEALL;
        END;
    end;

    var
        buff: Record "ACA-Stages Buffer";
        Progstages: Record "ACA-Programme Stages";
}

