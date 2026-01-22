page 51902 "REG-Mail Register Card"
{
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "REG-Mail Register";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = All;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                }
                field("Dispatched by"; Rec."Dispatched by")
                {
                    ApplicationArea = All;
                }
                field("stamp cost"; Rec."stamp cost")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Doc Ref No."; Rec."Doc Ref No.")
                {
                    ApplicationArea = All;
                }
                field("File Tab"; Rec."File Tab")
                {
                    ApplicationArea = All;
                }
                field("Folio No"; Rec."Folio No")
                {
                    ApplicationArea = All;
                }
                field("Person Recording"; Rec."Person Recording")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Mail)"; Rec."Delivered By (Mail)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Phone)"; Rec."Delivered By (Phone)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Name)"; Rec."Delivered By (Name)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (ID)"; Rec."Delivered By (ID)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Town)"; Rec."Delivered By (Town)")
                {
                    ApplicationArea = All;
                }
            }
        }
        /* area(factboxes)
        {
            systempart(; Notes)
            {
            }
            systempart(; MyNotes)
            {
            }
            systempart(; Links)
            {
            }
        } */
    }

    actions
    {
    }
}

