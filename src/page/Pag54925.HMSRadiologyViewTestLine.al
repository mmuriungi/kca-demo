page 54925 "HMS-Radiology View Test Line"
{
    Editable = false;
    PageType = Document;
    SourceTable = "HMS-Radiology Form Line";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Radiology Type Code"; Rec."Radiology Type Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology Type Name"; Rec."Radiology Type Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Performed Date"; Rec."Performed Date")
                {
                    ApplicationArea = All;
                }
                field("Performed Time"; Rec."Performed Time")
                {
                    ApplicationArea = All;
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
            action("Radiology Image(s)")
            {
                Caption = 'Radiology Image(s)';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RadiologyLine.RESET;
                    RadiologyLine.SETRANGE(RadiologyLine."Radiology no.", Rec."Radiology no.");
                    RadiologyLine.SETRANGE(RadiologyLine."Radiology Type Code", Rec."Radiology Type Code");
                    PAGE.RUN(52573, RadiologyLine);
                end;
            }
        }
    }

    var
        RadiologyLine: Record "HMS-Radiology Form Line";
}

