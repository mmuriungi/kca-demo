report 50964 "Compute Returned Leaves"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {

            trigger OnAfterGetRecord()
            begin
                HRMLeaveLedger.RESET;
                HRMLeaveLedger.SETRANGE("Employee No", "HRM-Employee C"."No.");
                HRMLeaveLedger.SETCURRENTKEY("Employee No", "Transaction Date");
                IF HRMLeaveLedger.FIND('+') THEN BEGIN
                    HRMLeaveRequisition.CALCFIELDS(HRMLeaveRequisition."Starting Date", HRMLeaveRequisition."End Date");
                    IF HRMLeaveRequisition."End Date" > TODAY THEN BEGIN
                        "HRM-Employee C"."On Leave" := TRUE;
                        "HRM-Employee C"."Current Leave Start" := HRMLeaveRequisition."Starting Date";
                        "HRM-Employee C"."Current Leave End" := HRMLeaveRequisition."End Date";
                        "HRM-Employee C"."Current Leave Type" := HRMLeaveRequisition."Leave Type";
                        "HRM-Employee C"."Current Leave Applied Days" := HRMLeaveRequisition."Applied Days";
                        "HRM-Employee C".MODIFY;
                    END ELSE BEGIN
                        "HRM-Employee C"."On Leave" := FALSE;
                        "HRM-Employee C"."Current Leave Start" := 0D;
                        "HRM-Employee C"."Current Leave End" := 0D;
                        "HRM-Employee C"."Current Leave Type" := '';
                        "HRM-Employee C"."Current Leave Applied Days" := 0;
                        "HRM-Employee C".MODIFY;
                    END;
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

    var
        HRMLeaveLedger: Record "HRM-Leave Ledger";
        HRMLeaveRequisition: Record "HRM-Leave Requisition";
}

