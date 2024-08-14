pageextension 50201 chartofaccounts extends "Chart of Accounts"
{
    layout
    {
        addafter(Balance)
        {
            // field("Budget Controlled"; Rec."Budget Controlled")
            // {
            //     ApplicationArea = All;

            //     Editable = true;
            // }
        }
    }
    actions
    {
        addafter("G/L Register")
        {
            action(printReport2)
            {
                Caption = 'Trial Balance Summary';
                ApplicationArea = All;
                RunObject = report "Trial Balance Detail/Summary";
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

            }
            action(printReport)
            {
                Caption = 'Trial Balance Summary2';
                ApplicationArea = All;
                RunObject = report "Trial Balance Detail/Summary2";
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

            }


        }


    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //Rec.LoadFields(Indentation);
        Rec.SetLoadFields(Indentation)
    end;
}