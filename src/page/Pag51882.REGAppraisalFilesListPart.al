page 51882 "REG-AppraisalFiles ListPart"
{
    Caption = 'REG-AppraisalFiles ListPart';
    PageType = ListPart;
    SourceTable = "REG-Files Appraisal";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                    TableRelation = "REG-Files"."File Index";
                    trigger OnValidate()
                    var
                        RF: Record "REG-Files";
                    begin
                        RF.SetRange("File Index", Rec."File Index");
                        if RF.Find('-') then begin
                            Rec."File Name" := RF."File Name";
                            // Region := RF.Region;
                            Rec.Modify;
                        end;
                    end;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Volume; Rec.Volume)
                {
                    ToolTip = 'Specifies the value of the Volume field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
