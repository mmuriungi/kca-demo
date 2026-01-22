/// <summary>
/// Page Annual Workplan Listpart (ID 50007).
/// </summary>
page 50708 "Annual Workplan Listpart"
{
    Caption = 'Workplan Details';
    PageType = ListPart;
    SourceTable = "Annual Workplan List";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Financial Period"; Rec."Financial Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Period field.';
                }
                field("S/N"; Rec."S/N")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the S/N field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }



                field("Key Result Area"; Rec."Key Result Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Result Area field.';
                }
                field("Strategic Objective"; Rec."Strategic Objective")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Strategic Objective field.';
                }
                field("Projected Output"; Rec."Projected Output")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Projected Output field.';
                }
                field(Activities; Rec.Activities)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activities field.';
                }
                field("Approved Budget Gok"; Rec."Approved Budget Gok")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Budget Gok field.';
                }
                field("Approved Budget Donor"; Rec."Approved Budget Donor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Budget Donor field.';
                }
                field("Target in FY "; Rec."Target in FY ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target in FY  field.';
                }
                field("Means of Verification"; Rec."Means of Verification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Means of Verification field.';
                }


                field(July; Rec.July)
                {
                    ApplicationArea = All;

                    ToolTip = 'Specifies the value of the July field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(August; Rec.August)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the August field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(September; Rec.September)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the September field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(October; Rec.October)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the October field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(November; Rec.November)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the November field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(December; Rec.December)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the December field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(January; Rec.January)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the January field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(February; Rec.February)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the February field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(March; Rec.March)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the March field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(April; Rec.April)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the April field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(May; Rec.May)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the May field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }
                field(June; Rec.June)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the June field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateToTimeline();
                    end;
                }

                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility field.';
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transferred field.';
                }


            }
        }
    }
}
