// Page: Recent Incidents List
page 50316 "Recent Incidents List"
{
    PageType = ListPart;
    SourceTable = "Incident Report";
    Caption = 'Recent Incidents';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field("Accused Name"; Rec."Accused Name")
                {
                    ApplicationArea = All;
                }
                field("Nature of Case"; Rec."Nature of Case")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Open);
    end;
}