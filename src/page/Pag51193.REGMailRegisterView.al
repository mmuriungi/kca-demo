page 51193 "REG-Mail Register View"
{
    Editable = false;
    PageType = List;
    SourceTable = "REG-Mail Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Subject of Doc."; Rec."Subject of Doc.")
                {
                }
                field("Mail Date"; Rec."Mail Date")
                {
                }
                field(Addressee; Rec.Addressee)
                {
                }
                field("mail Time"; Rec."mail Time")
                {
                }
                field(Receiver; Rec.Receiver)
                {
                }
                field("Addresee Type"; Rec."Addresee Type")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Doc type"; Rec."Doc type")
                {
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                }
                field("Direction Type"; Rec."Direction Type")
                {
                }
                field("Folio Number"; Rec."Folio Number")
                {
                }
                field(Received; Rec.Received)
                {
                }
                field(Dispatched; Rec.Dispatched)
                {
                }
                field("Dispatched by"; Rec."Dispatched by")
                {
                }
                field("stamp cost"; Rec."stamp cost")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Doc Ref No."; Rec."Doc Ref No.")
                {
                }
                field("File Tab"; Rec."File Tab")
                {
                }
                field("Folio No"; Rec."Folio No")
                {
                }
                field("Person Recording"; Rec."Person Recording")
                {
                }
                field("Delivered By (Mail)"; Rec."Delivered By (Mail)")
                {
                }
                field("Delivered By (Phone)"; Rec."Delivered By (Phone)")
                {
                }
                field("Delivered By (Name)"; Rec."Delivered By (Name)")
                {
                }
                field("Delivered By (ID)"; Rec."Delivered By (ID)")
                {
                }
                field("Delivered By (Town)"; Rec."Delivered By (Town)")
                {
                }
                field("Mail Status"; Rec."Mail Status")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Disp)
            {
                Caption = 'Dispatch';
                Image = ReleaseShipment;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Subject of Doc.");
                    Rec.TestField("Mail Date");
                    Rec.TestField(Addressee);
                    Rec.TestField("mail Time");
                    Rec.TestField(Receiver);
                    Rec.TestField(Comments);
                    Rec.TestField("Delivered By (Mail)");
                    Rec.TestField("Delivered By (Phone)");
                    Rec.TestField("Delivered By (Name)");
                    Rec.TestField("Delivered By (ID)");
                    Rec.TestField("Delivered By (Town)");

                    if (Confirm('Send mail to dispatch?', true) = true) then begin
                        Rec."Mail Status" := Rec."Mail Status"::Dispatch;
                        Rec.Modify;
                    end;
                    Message('Successfully send to dispatch.');
                end;
            }
        }
    }
}

