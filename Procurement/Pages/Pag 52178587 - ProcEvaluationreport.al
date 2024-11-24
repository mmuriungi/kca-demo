page 52178587 "Proc-Evaluation report"
{
    PageType = Card;
    SourceTable = "Proc Evaluation Report";
    layout
    {
        area(Content)
        {
            group(general)
            {
                field(staffNo; staffNo)
                {
                    Caption = 'Staff No.';
                    ApplicationArea = All;
                    TableRelation = "HRM-Employee C"."No.";
                }
                field(staffPass; staffPass)
                {
                    Caption = 'Portal Password';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Submit")
            {
                ApplicationArea = All;
                Image = SuggestNumber;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    EvaluateTender();
                    CurrPage.Close();
                end;


            }
        }

    }

    var
        Val: Record "Proc-Confirm Recommended";
        staffNo: Code[30];
        staffPass: Text;

        hrm: Record "HRM-Employee C";

    procedure EvaluateTender()
    begin
        hrm.Reset();
        hrm.SetRange("No.", staffNo);
        hrm.SetRange("Portal Password", staffPass);
        if hrm.Find('-') then begin
            if hrm."Portal Password" = '' then Error('You do not have a valid portal password');
            Val.Reset();
            Val.SetRange("Staff No.", hrm."No.");
            Val.SetRange(confirmed, false);
            page.Run(Page::"Proc-Evaluation Confirmation", Val);

        end else
            Error('Check your password');

    end;
}