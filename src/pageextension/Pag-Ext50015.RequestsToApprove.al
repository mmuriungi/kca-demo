pageextension 50015 "Requests To Approve" extends "Requests to Approve"
{
    layout
    {
        addbefore("ToApprove")
        {
            field("Document No."; rec."Document No.")
            {
                ApplicationArea = All;
                Visible = true;
            }

        }
        modify("Amount (LCY)")
        {

            Visible = false;

        }
        modify(Amount)
        {
            Visible = false;
        }

    }
    actions
    {
        modify(Reject)
        {
            trigger OnAfterAction()
            var
            // myInt: Integer;
            begin
                // page.Run(660);
                Approvalcomments.reset;
                // Approvalcomments.SetRange("Document No.", rec."Document No.");
                Approvalcomments.SetRange("Table ID", Rec."Table ID");
                Approvalcomments.SetRange("Record ID to Approve", rec."Record ID to Approve");
                Approvalcomments.SetRange("Workflow Step Instance ID", rec."Workflow Step Instance ID");
                if Approvalcomments.FindFirst() then begin


                end else
                    Error('Please insert a comment before rejecting');
            end;


        }
    }
    var
        Approvalcomments: Record 455;
}

