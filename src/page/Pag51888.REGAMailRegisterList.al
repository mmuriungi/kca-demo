page 51888 "REG-A-Mail Register List"
{
    CardPageID = "REG-Mail Register List";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "REG-Mail Register (B)";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Subject of Doc."; Rec."Subject of Doc.")
                {
                    ApplicationArea = All;
                }
                field("Mail Date"; Rec."Mail Date")
                {
                    ApplicationArea = All;
                }
                field(Addressee; Rec.Addressee)
                {
                    ApplicationArea = All;
                }
                field("mail Time"; Rec."mail Time")
                {
                    ApplicationArea = All;
                }
                field(Receiver; Rec.Receiver)
                {
                    ApplicationArea = All;
                }
                field("Addresee Type"; Rec."Addresee Type")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Doc type"; Rec."Doc type")
                {
                    ApplicationArea = All;
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = All;
                }
                field("Direction Type"; Rec."Direction Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

