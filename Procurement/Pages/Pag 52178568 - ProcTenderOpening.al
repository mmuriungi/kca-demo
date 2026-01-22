page 52178568 "Proc-Tender Opening"
{
    PageType = Card;
    SourceTable = "Proc-Committee Membership";
    SourceTableView = where("Committee Type" = filter("Opening Commitee"));


    layout
    {
        area(Content)
        {
            group(General)
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
                    OpenTender();
                    CurrPage.Close();
                end;


            }
        }

    }
    var
        staffNo: Code[30];
        staffPass: Text;
        tcomm: Record "Proc-Committee Membership";
        hrm: Record "HRM-Employee C";



    procedure OpenTender()
    begin
        hrm.Reset();
        hrm.SetRange("No.", staffNo);
        hrm.SetRange("Portal Password", staffPass);
        if hrm.Find('-') then begin
            if hrm."Portal Password" = '' then Error('You do not have a valid portal password');
            tcomm.Reset();
            tcomm.SetRange("Staff No.", hrm."No.");
            tcomm.SetRange("Opening Confirmed", false);
            tcomm.SetRange("Committee Type", tcomm."Committee Type"::"Opening Commitee");
            page.Run(Page::"Proc-Opening Commitee.Open", tcomm);
        end else
            Error('Check your password');

    end;

}