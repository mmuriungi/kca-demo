// Page: Upcoming Events
page 50325 "Upcoming Events"
{
    PageType = ListPart;
    SourceTable = "CRM Event";
    Caption = 'Upcoming Events';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Registered Attendees"; Rec."Registered Attendees")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Date, WorkDate(), CalcDate('<+30D>', WorkDate()));
        Rec.SetCurrentKey(Date);
    end;
}
