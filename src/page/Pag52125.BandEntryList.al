page 52125 "Band Entry List"
{
    ApplicationArea = All;
    Caption = 'Band Entry List';
    PageType = List;
    SourceTable = "Funding Band Entries";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = Basic;
                }
                field("Student Exists"; Rec."Student Exists")
                {
                    ApplicationArea = Basic;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = Basic;
                }
                field("Admission Year"; Rec."Admission Year")
                {
                    ApplicationArea = Basic;
                }
                field("KCSE Index No."; Rec."KCSE Index No.")
                {
                    ApplicationArea = Basic;
                }
                field("Band Code"; Rec."Band Code")
                {
                    ApplicationArea = Basic;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = Basic;
                }
                field("Programme Cost"; Rec."Programme Cost")
                {
                    ApplicationArea = Basic;
                }
                field("HouseHold Percentage"; Rec."HouseHold Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("HouseHold Fee"; Rec."HouseHold Fee")
                {
                    ApplicationArea = Basic;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
