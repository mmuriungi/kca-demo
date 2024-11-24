page 52178570 "Proc-TechnicalQEval"
{
    PageType = Card;
    SourceTable = "Proc-Technical Qualif.Quote";
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
        TVal: Record "Proc-Technical Qualif.Quote";
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
            TVal.Reset();
            TVal.SetRange("Staff No", hrm."No.");
            // TVal.SetRange(evaluated, false);
            page.Run(Page::"Proc-Technical Qualif.Qualify", TVal);

        end else
            Error('Check your password');

    end;
}