page 51906 "REG-New Inbound Mails List"
{
    CardPageID = "REG-New Inbound Mails Document";
    PageType = List;
    SourceTable = "REG-Mail Register";
    SourceTableView = WHERE("Direction Type" = FILTER("Incoming Mail (Internal)" | "Incoming Mail (External)"),
                            "Mail Status" = FILTER(New));

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
                field(Receiver; Rec.Receiver)
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
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Doc Ref No."; Rec."Doc Ref No.")
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
        area(creation)
        {
            action(Sort)
            {
                Caption = 'Send for Sorting';
                Image = ReleaseShipment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Subject of Doc.");
                    Rec.TESTFIELD("Mail Date");
                    Rec.TESTFIELD(Addressee);
                    Rec.TESTFIELD("mail Time");
                    Rec.TESTFIELD(Receiver);
                    Rec.TESTFIELD(Comments);
                    Rec.TESTFIELD("Delivered By (Mail)");
                    Rec.TESTFIELD("Delivered By (Phone)");
                    Rec.TESTFIELD("Delivered By (Name)");
                    Rec.TESTFIELD("Delivered By (ID)");
                    Rec.TESTFIELD("Delivered By (Town)");

                    IF NOT (CONFIRM('Send mail to Sorting?', TRUE) = TRUE) THEN
                        ERROR('Cancelled!') ELSE BEGIN
                        Rec."Mail Status" := Rec."Mail Status"::Sorted;
                        Rec.Receiver := USERID;
                        Rec.Received := TRUE;
                        Rec.MODIFY;
                    END;
                    MESSAGE('Successfully send for sorting.');
                end;
            }
        }
    }
}

