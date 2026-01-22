page 51908 "REG-New Outbound Mails List"
{
    CardPageID = "REG-New Outbound Mails Doc.";
    PageType = List;
    SourceTable = "REG-Mail Register";
    SourceTableView = WHERE("Direction Type" = FILTER("Outgoing Mail (Internal)" | "Outgoing Mail (External)"),
                            "Mail Status" = FILTER(New));

    layout
    {
        area(content)
        {
            repeater(General)
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
            action(Disp)
            {
                Caption = 'Request Dispatch';
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
                    Rec.TESTFIELD(Comments);


                    IF NOT (CONFIRM('Send mail to dispatch?', TRUE) = TRUE) THEN
                        ERROR('Cancelled!') ELSE BEGIN
                        Rec."Mail Status" := Rec."Mail Status"::Dispatch;
                        Rec.Dispatched := TRUE;
                        Rec."Dispatched by" := USERID;
                        Rec.MODIFY;
                    END;
                    MESSAGE('Successfully send to dispatch.');
                end;
            }
        }
    }
}

