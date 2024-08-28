page 51442 "Visitors Ledger Card"
{
    PageType = Card;
    SourceTable = "Visitors Ledger";
    Caption = 'Visitors Ledger Card';

    layout
    {
        area(content)
        {
            group("Visitor Ledger Edit")
            {
                field("Visit No."; Rec."Visit No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = editableBool;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    Editable = editableBool;
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Editable = editableBool;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = editableBool;
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    Editable = editableBool;
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    Editable = editableBool;
                    ApplicationArea = All;
                }
                field("Office Station/Department"; Rec."Office Station/Department")
                {
                    ApplicationArea = All;
                    // Editable = editableBool;

                    // trigger OnValidate()
                    // begin
                    //     CurrPage.UPDATE;
                    // end;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Signed in by"; Rec."Signed in by")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    Editable = editableBool;
                    ApplicationArea = All;
                }
                field("Comment By"; Rec."Comment By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Det)
            {
                Caption = 'Personal Items Recording';
                part("Visitor Personal Items"; "Visitor Personal Items")
                {
                    SubPageLink = "Visitor Code" = FIELD("Visit No."),
                                  "Visitor ID" = FIELD("ID No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Check In")
            {
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    readMessage: Text[100];
                begin
                    CLEAR(readMessage);
                    IF Rec."Time In" <> 0T THEN ERROR('Already Checked in!');
                    users1.RESET;
                    users1.SETRANGE("User Name", USERID);
                    IF users1.FIND('-') THEN BEGIN END;
                    Rec.TESTFIELD(Rec.Company);
                    Rec.TESTFIELD(Rec."ID No.");
                    Rec.TESTFIELD(Rec."Phone No.");
                    Rec.TESTFIELD(Rec."Full Name");
                    IF CONFIRM('Check-in ' + Rec."Full Name" + ' as a Visitor?', TRUE) = FALSE THEN ERROR('Check-in Cancelled by ' + USERID);
                    Rec."Transaction Date" := TODAY;
                    Rec."Time In" := TIME;
                    IF users1."Full Name" = '' THEN
                        Rec."Signed in by" := USERID
                    ELSE
                        Rec."Signed in by" := users1."Full Name";
                    Rec.MODIFY;
                    readMessage := 'Checked in Successfully!';
                    IF NOT VisitorCard.GET(Rec."ID No.") THEN BEGIN
                        // Create a record in the Visitor Card
                        VisitorCard.INIT;
                        VisitorCard."ID No." := Rec."ID No.";
                        VisitorCard."Full Names" := Rec."Full Name";
                        VisitorCard."Phone No." := Rec."Phone No.";
                        VisitorCard.Email := Rec.Email;
                        VisitorCard."Company Name" := Rec.Company;
                        VisitorCard."Reg. Date" := TODAY;
                        VisitorCard."Reg. Time" := TIME;
                        VisitorCard."Registered By" := USERID;
                        VisitorCard.INSERT;
                        readMessage := 'Checked in and Account Created Successfully!';
                    END;
                    MESSAGE(readMessage);
                end;
            }
            action("Check Out")
            {
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemstoCheckOut: Record "Visitor Personal Items";
                begin

                    IF Rec."Time In" = 0T THEN ERROR('Not Checked in!');
                    Rec.TESTFIELD(Comment);
                    IF Rec."Checked Out" = TRUE THEN ERROR('Already Checked out!');

                    ItemstoCheckOut.RESET;
                    ItemstoCheckOut.SETRANGE(ItemstoCheckOut."Visitor Code", Rec."Visit No.");
                    ItemstoCheckOut.SETRANGE(ItemstoCheckOut."Visitor ID", Rec."ID No.");
                    ItemstoCheckOut.SETRANGE(ItemstoCheckOut.Cleared, FALSE);
                    ItemstoCheckOut.SETFILTER(ItemstoCheckOut."Item Description", '<>%1', '');
                    IF ItemstoCheckOut.FIND('-') THEN BEGIN
                        ERROR('Please Check out all Peronal Items First');
                    END;

                    users1.RESET;
                    users1.SETRANGE("User Name", USERID);
                    IF users1.FIND('-') THEN BEGIN END;
                    IF CONFIRM('Check-out ' + Rec."Full Name" + '?', TRUE) = FALSE THEN ERROR('Check-out Cancelled by ' + USERID);
                    Rec."Time Out" := TIME;
                    Rec."Checked Out" := TRUE;
                    IF users1."Full Name" = '' THEN
                        Rec."Signed Out By" := USERID
                    ELSE
                        Rec."Signed Out By" := users1."Full Name";
                    Rec.MODIFY;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF ((Rec."Checked Out" = TRUE) OR (Rec."Signed in by" <> '')) THEN editableBool := FALSE ELSE editableBool := TRUE;
    end;

    trigger OnInit()
    begin
        editableBool := TRUE;
    end;

    var
        users1: Record "User";
        editableBool: Boolean;
        VisitorCard: Record "Visitor Card";
}

