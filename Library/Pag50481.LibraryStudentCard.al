page 50092 "Library Student Card"
{
    Caption = 'Library Student List';
    SourceTable = Customer;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                    CaptionML = ENU = 'Town';
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
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
                    KohaHandler.createStudentPatron(Rec);
                end;
            }
        }
    }
}
