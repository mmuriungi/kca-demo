page 51043 "ACA-LectureHalls Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-Lecturer Halls Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Lecture Room Code"; Rec."Lecture Room Code")
                {
                    ApplicationArea = All;
                }
                field("Lecture Room Name"; Rec."Lecture Room Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Hall Category"; Rec."Hall Category")
                {
                    ApplicationArea = All;
                }

                field("Sitting Capacity"; Rec."Sitting Capacity")
                {
                    ApplicationArea = All;
                }
                field("Exam Sitting Capacity"; Rec."Exam Sitting Capacity")
                {
                    ApplicationArea = All;
                }
                field("Building Code"; Rec."Building Code")
                {
                    ApplicationArea = All;
                }
                field(Floor;Rec.Floor)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    Caption = 'Campus Code';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Serial; Rec.Serial)
                {
                    ApplicationArea = ALL;
                }
                field("Available Equipment"; Rec."Available Equipment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }


    var
        myInt: Integer;
        AllowAccessSettings: boolean;
}