pageextension 50007 "Bank Account Reconcilation" extends "Bank Acc. Reconciliation"
{
    actions
    {


        addafter("P&osting")
        {
            action("&Test Report2")
            {

                Caption = 'Test Bank Rec. Report';
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SetFilter("Statement No.", Rec."Statement No.");
                    Rec.SetFilter("Bank Account No.", Rec."Bank Account No.");
                    REPORT.RUN(50019, TRUE, TRUE, Rec);
                end;
            }

        }
    }
}
