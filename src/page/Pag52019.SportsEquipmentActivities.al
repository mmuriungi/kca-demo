// Page: Sports Equipment Activities
page 52019 "Sports Equipment Activities"
{
    PageType = CardPart;
    SourceTable = "Sports Equipment Cue";

    layout
    {
        area(content)
        {
            cuegroup(Activities)
            {
                Caption = 'Activities';
                field(IssuedEquipment; Rec."Issued Equipment")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Equipment Issuance";
                }
                field(OverdueEquipment; Rec."Overdue Equipment")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Equipment Issuance";
                }
                field(LostEquipment; Rec."Lost Equipment")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Equipment Issuance";
                }
            }
        }
    }
}
