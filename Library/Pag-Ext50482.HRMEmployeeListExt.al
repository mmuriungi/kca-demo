pageextension 50482 "HRM-Employee List Ext" extends "HRM-Employee List"
{
    actions
    {
        addafter("Committe Membership")
        {
            action("Send to Koha")
            {
                ApplicationArea = All;
                Image = LiFo;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    KohaHandler: Codeunit "Koha Handler";
                begin
                    KohaHandler.createStaffPatron(Rec);
                end;
            }
        }
    }
}
