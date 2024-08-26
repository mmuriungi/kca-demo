// Page: Incident Report Card
page 50310 "Incident Report Card"
{
    PageType = Card;
    SourceTable = "Incident Report";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field("Accused Name"; Rec."Accused Name")
                {
                    ApplicationArea = All;
                }
                field("Victim/Reporting Party"; Rec."Victim/Reporting Party")
                {
                    ApplicationArea = All;
                }
                field("Nature of Case"; Rec."Nature of Case")
                {
                    ApplicationArea = All;
                }
                field("Accused ID Number"; Rec."Accused ID Number")
                {
                    ApplicationArea = All;
                }
                field("Accused Phone Number"; Rec."Accused Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Accused Residence"; Rec."Accused Residence")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Accused Type"; Rec."Accused Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Forwarded To"; Rec."Forwarded To")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
