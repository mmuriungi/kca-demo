page 50220 "Proc-PreliminaryQEval"
{
    PageType = Card;
    SourceTable = "Proc-Preliminary Qualif.Quote";
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
        premQ: Record "Proc-Preliminary Qualif.Quote";
        staffNo: Code[30];
        staffPass: Text;
        //premQ: Record "Proc-Committee Membership";
        hrm: Record "HRM-Employee C";

    procedure EvaluateTender()
    begin
        hrm.Reset();
        hrm.SetRange("No.", staffNo);
        hrm.SetRange("Portal Password", staffPass);
        if hrm.Find('-') then begin
            if hrm."Portal Password" = '' then Error('You do not have a valid portal password');

            premQ.Reset();
            premQ.SetRange("Staff No", hrm."No.");
            // premQ.SetRange(evaluated, false);
            page.Run(Page::"Proc-PreliminaryQualif.Qualify", premQ);

        end else
            Error('Check your password');

    end;
}