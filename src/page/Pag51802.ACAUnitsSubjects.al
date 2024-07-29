page 51802 "ACA-Units/Subjects"
{
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "ACA-Units/Subjects";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Code field.';
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Name field.';
                }
                field("Key Course"; Rec."Key Course")
                {
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field("Old Unit"; Rec."Old Unit")
                {
                    ApplicationArea = All;
                }
                field("No. Units"; Rec."No. Units")
                {
                    Caption = 'CF';
                    ApplicationArea = All;
                }
                field("Programme Option"; Rec."Programme Option")
                {
                    ApplicationArea = All;
                }
                field("Default Exam Category"; Rec."Default Exam Category")
                {
                    ApplicationArea = All;
                }
                field("Combination Count"; Rec."Combination Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Not Allocated"; Rec."Not Allocated")
                {
                    ApplicationArea = All;
                }
                field("Common Unit"; Rec."Common Unit")
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    Caption = 'Credit Hours';
                    ApplicationArea = All;
                }
                field("Academic Hours"; Rec."Academic Hours")
                {
                    ApplicationArea = All;
                }
                field(Prerequisite; Rec.Prerequisite)
                {
                    ApplicationArea = All;
                }
                field("Students Registered"; Rec."Students Registered")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                }
                field("Last Modified by"; Rec."Last Modified by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified by field.';
                }
                field("Date Last Modified"; Rec."Date Last Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Last Modified field.';
                }
                field("Time Last Modified"; Rec."Time Last Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Last Modified field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Save New Units")
            {
                Caption = 'Save New Units';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UnitsSubj.RESET;
                    UnitsSubj.SETFILTER(UnitsSubj."New Unit", '%1', TRUE);
                    IF UnitsSubj.FIND('-') THEN BEGIN
                        REPEAT
                            UnitsSubj."New Unit" := FALSE;
                            UnitsSubj.MODIFY;
                        UNTIL UnitsSubj.NEXT = 0;
                    END;
                end;
            }
            group(Unit)
            {
                Caption = 'Unit';
                action("Fees Structure")
                {
                    Caption = 'Fees Structure';
                    RunObject = Page "ACA-Fees By Unit";
                    RunPageLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD("Stage Code"),
                                  "Unit Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
            group("Multiple Combination")
            {
                Caption = 'Multiple Combination';
                action("Multiple Option Combination")
                {
                    Caption = 'Multiple Option Combination';
                    RunObject = Page "ACA-Units Option Combination";
                    RunPageLink = Programme = FIELD("Programme Code"),
                                  Stage = FIELD("Stage Code"),
                                  Unit = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        UnitsSubj: Record "ACA-Units/Subjects";
}

