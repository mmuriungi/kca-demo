page 55141 "REG-Incoming Mail Reg. Card"
{
    PageType = Card;
    SourceTable = "REG-Mail Register (B)";
    SourceTableView = WHERE("Direction Type" = FILTER(= "Incoming Mail (Internal)"),
                            Received = FILTER(= false));

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
                    OptionCaption = 'Incoming Mail (Internal),Incoming Mail (External)';
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReceiveNotify)
            {
                Caption = 'Receive And Notify';
                Ellipsis = true;
                Image = "Action";
                Promoted = true;
                PromotedIsBig = true;
                RunPageMode = View;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Received := TRUE;
                    Rec.MODIFY;
                    MESSAGE('Received and Email Sent');
                end;
            }
            action("Receive Only")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Received := TRUE;
                    Rec.MODIFY;
                    MESSAGE('Received');
                end;
            }
        }
    }
}

