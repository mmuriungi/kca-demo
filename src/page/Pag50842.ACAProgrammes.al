page 50842 "ACA-Programmes"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ACA-Programme";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Programme Code';
                }
                field("Old Code"; Rec."Old Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Programme Name';
                }
                field("Programme Leader"; Rec."Program Leader")
                {
                    Caption = 'Prog Leader Staff ID';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Program Leader Name';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Category; Rec.Category)
                {
                    Editable = true;
                    Enabled = true;
                    Visible = False;
                    ApplicationArea = All;
                }
                // field(Levels; Rec.Levels)
                // {
                //     Caption = 'Level Code';
                //     ApplicationArea = All;
                // }
                field(Levels; Rec.Levels)
                {
                    Caption = 'Level Code';
                    ApplicationArea = All;
                }
                field("Program Status"; Rec."Program Status")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                // field(Faculty; Rec.Faculty)
                // {
                //     Caption = 'School';
                //     ApplicationArea = All;
                // }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = ALL;
                }
                field("School Name";Rec."School Name")
                {
                    ApplicationArea = All;
                }
                // field("Faculty Name"; Rec."Faculty Name")
                // {
                //     ApplicationArea = All;
                // }

                field("Campus Code"; Rec."Campus Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;

                }
                // field(Iteration; Rec.Iteration)
                // {
                //     ApplicationArea = All;
                // }

                /*  field("Minimum Capacity"; Rec."Minimum Capacity")
                 {
                     ApplicationArea = All;
                 }
                 field("Maximum Capacity"; Rec."Maximum Capacity")
                 {
                     ApplicationArea = All;
                 }
                 field("Min No. of Courses"; Rec."Min No. of Courses")
                 {
                     ApplicationArea = All;
                 }
                 field("Max No. of Courses"; Rec."Max No. of Courses")
                 {
                     ApplicationArea = All;
                 }
                 field("Min Pass Units"; Rec."Min Pass Units")
                 {
                     ApplicationArea = All;
                 }
                 field("Minimum Grade"; Rec."Minimum Grade")
                 {
                     ApplicationArea = All;
                 }
                 field("Minimum Points"; Rec."Minimum Points")
                 {
                     ApplicationArea = All;
                 } */
                field("Exam Category"; Rec."Exam Category")
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Student Registered"; Rec."Student Registered")
                {
                    ApplicationArea = All;
                }
                field("Programme Units"; Rec."Programme Units")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Graduation Units"; Rec."Graduation Units")
                {
                    ApplicationArea = All;
                }
                field("Unit Fee"; Rec."Unit Fee")
                {
                    //Visible = false;
                    ApplicationArea = All;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Semester Filter"; Rec."Semester Filter")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Special Programme"; Rec."Special Programme")
                {
                    ApplicationArea = All;
                }
                field("Special Programme Class"; Rec."Special Programme Class")
                {
                    Visible = false;
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Not Classified"; Rec."Not Classified")
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Show Options on Graduation"; Rec."Show Options on Graduation")
                {
                    Visible = false;
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Use Stage Semesters"; Rec."Use Stage Semesters")
                {
                    ApplicationArea = All;
                }
                field("Program Leader"; Rec."Program Leader")
                {

                }
                field(ApplicationFee; Rec.ApplicationFee)
                {
                    ApplicationArea = All;
                }
            }
            field("Program Requirement"; Rec."Program Requirement")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Programme)
            {
                Caption = 'Programme';
                action(Semesters)
                {
                    Caption = 'Semesters';
                    Ellipsis = true;
                    Image = Worksheet;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = New;
                    RunObject = Page "ACA-Programme Semesters";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action(Stages)
                {
                    Caption = 'Stages';
                    Ellipsis = false;
                    Image = LedgerBook;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    RunObject = Page "ACA-Programme Stages";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Defined Graduation Units")
                {
                    Caption = 'Defined Graduation Units';
                    Ellipsis = false;
                    Image = MakeDiskette;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    RunObject = Page "ACA-Prog. Defined Units/YoS";
                    RunPageLink = Programmes = FIELD(Code);
                    ApplicationArea = All;
                }
                action("New Student Charges")
                {
                    Caption = 'New Student Charges';
                    Image = CheckJournal;
                    Promoted = true;
                    RunObject = Page "ACA-New Student Charges";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }

                action("Release Allocation")
                {
                    Caption = 'Release Allocation';
                    Image = Worksheet;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // TimeTable.RESET;
                        // TimeTable.SETRANGE(TimeTable.Programme, Rec.Code);
                        // IF TimeTable.FIND('-') THEN BEGIN
                        //     REPEAT
                        //         TimeTable.Released := TRUE;
                        //         TimeTable.MODIFY;
                        //     UNTIL TimeTable.NEXT = 0;

                        // END;

                        MESSAGE('Release completed successfully.');
                    end;
                }
                action("Undo Release Allocation")
                {
                    Caption = 'Undo Release Allocation';
                    Image = Worksheet;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // TimeTable.RESET;
                        // TimeTable.SETRANGE(TimeTable.Programme, Rec.Code);
                        // IF TimeTable.FIND('-') THEN BEGIN
                        //     REPEAT
                        //         TimeTable.Released := FALSE;
                        //         TimeTable.MODIFY;
                        //     UNTIL TimeTable.NEXT = 0;

                        // END;

                        MESSAGE('Process completed successfully.');
                    end;
                }

                action("Entry Subjects")
                {
                    Caption = 'Entry Subjects';
                    Image = Entries;
                    Promoted = true;
                    RunObject = Page "ACA-Programme Entry Subjects";
                    RunPageLink = Programme = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Admission Req. Narration")
                {
                    Image = Worksheet;
                    RunObject = Page "ACA-Admission Narration";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                separator(_____)
                {
                }
                action("Programme Options")
                {
                    Caption = 'Programme Options';
                    Image = Worksheet;
                    RunObject = Page "ACA-Programme Option";
                    RunPageLink = "Programme Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Category := Rec.Category::Diploma;
    end;

    var
    // TimeTable: Record "ACA-Time Table";
}

