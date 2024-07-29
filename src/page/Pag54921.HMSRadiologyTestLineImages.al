page 54921 "HMS-Radiology Test Line Images"
{
    PageType = ListPart;
    SourceTable = "HMS-Radiology Form Line Image";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology No."; Rec."Radiology No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
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
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        HasValue: Boolean;
}

