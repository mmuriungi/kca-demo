// Page: Sports Equipment Cues
page 52020 "Sports Equipment Cues"
{
    PageType = CardPart;
    SourceTable = "Sports Equipment Cue";

    layout
    {
        area(content)
        {
            cuegroup(Cues)
            {
                Caption = 'Sports Equipment';
                field(IssuedEquipment; Rec."Issued Equipment")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Equipment Issuance";
                }
                field(OverdueEquipment; Rec."Overdue Equipment")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    DrillDownPageId = "Equipment Issuance";
                }
                field(LostEquipment; Rec."Lost Equipment")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    DrillDownPageId = "Equipment Issuance";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.OverdueDate := CalcDate('<-7D>', Today);
        Rec.Modify();
    end;
}
