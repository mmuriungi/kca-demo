page 51918 "REG-Sorted Inbound Mails Doc."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "REG-Mail Register";
    SourceTableView = WHERE("Direction Type" = FILTER("Incoming Mail (Internal)" | "Incoming Mail (External)"),
                            "Mail Status" = FILTER(Sorted));

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
                field(Received; Rec.Received)
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
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

