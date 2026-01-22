page 52178571 "Proc-DemoQEval"
{
    PageType = Card;
    SourceTable = "Proc-Demo Qualif.Quote";
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
        DVal: Record "Proc-Demo Qualif.Quote";
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
            DVal.Reset();
            DVal.SetRange("Staff No", hrm."No.");
            //DVal.SetRange(evaluated, false);
            page.Run(Page::"Proc-Demo Qualif.Qualify", DVal);

        end else
            Error('Check your password');

    end;
}