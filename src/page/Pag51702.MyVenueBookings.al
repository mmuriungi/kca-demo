page 50090 "My Venue Bookings"
{
    Caption = 'My Venue Bookings';
    PageType = ListPart;
    SourceTable = "Gen-Venue Booking";
    SourceTableView = SORTING("Booking Id") ORDER(Descending);
    CardPageId = "Venue Booking Header";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Booking Id"; Rec."Booking Id")
                {
                    ApplicationArea = All;
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                }
                field("Booking Time"; Rec."Booking Time")
                {
                    ApplicationArea = All;
                }
                field("Meeting Description"; Rec."Meeting Description")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field("Venue Dscription"; Rec."Venue Dscription")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyleExpr;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create New Booking")
            {
                Caption = 'Create New Booking';
                Image = NewDocument;
                RunObject = Page "Venue Booking Header";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(SendForApproval)
            {
                Caption = 'Submit Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Department);
                    Rec.TESTFIELD("Request Date");
                    Rec.TESTFIELD("Booking Date");
                    Rec.TESTFIELD("Meeting Description");
                    Rec.TESTFIELD("Required Time");
                    Rec.TESTFIELD(Venue);
                    Rec.TESTFIELD("Contact Person");
                    Rec.TESTFIELD("Contact Number");
                    Rec.TESTFIELD(Pax);

                    IF CONFIRM('Submit request', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.MODIFY;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Requested By", USERID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    local procedure SetStatusStyle()
    begin
        StatusStyleExpr := 'Standard';

        case Rec.Status of
            Rec.Status::New:
                StatusStyleExpr := 'Standard';
            Rec.Status::"Pending Approval":
                StatusStyleExpr := 'Attention';
            Rec.Status::Approved:
                StatusStyleExpr := 'Favorable';
            Rec.Status::Cancelled:
                StatusStyleExpr := 'Unfavorable';
            Rec.Status::Rejected:
                StatusStyleExpr := 'Unfavorable';
        end;
    end;

    var
        StatusStyleExpr: Text;
}
