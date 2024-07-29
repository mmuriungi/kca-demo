page 54446 "Labaratory Results"
{
    Caption = 'Labaratory Results';
    PageType = ListPart;
    SourceTable = "Labaratory Results";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("specimen code"; Rec."specimen code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the specimen code field.', Comment = '%';
                }
                field("Lab Test"; Rec."Lab Test")
                {
                    ApplicationArea = All;
                    TableRelation = "Speciment  list"."Lab Test";
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                    trigger OnValidate()
                    var
                        LabResults: Record "Speciment  list";
                    begin
                        LabResults.Reset();
                        begin
                            rec."Lab Test Description" := LabResults."Lab Test Description";
                            rec."Normal Range" := LabResults."Normal Range";
                            rec.unit := LabResults.unit;
                            rec.Modify();
                        end;

                    end;
                }
                field("Lab Test Description"; Rec."Lab Test Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Test Description field.', Comment = '%';
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field(unit; Rec.unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field("Normal Range"; Rec."Normal Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flag field.', Comment = '%';
                }
            }
        }
    }
}
