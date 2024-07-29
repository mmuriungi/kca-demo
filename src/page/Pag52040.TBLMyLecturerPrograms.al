page 52040 TBLMyLecturerPrograms
{
    ApplicationArea = All;
    Caption = 'TBLMyLecturerPrograms';
    PageType = List;
    SourceTable = TBLMyLecturerPrograms;
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(ProgrammeCode; Rec.ProgrammeCode)
                {
                    ToolTip = 'Specifies the value of the ProgrammeCode field.';
                    ApplicationArea = All;
                }
                field("Program Name"; Rec."Program Name")
                {
                    ToolTip = 'Specifies the value of the Program Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(UserCode; Rec.UserCode)
                {
                    ToolTip = 'Specifies the value of the UserCode field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
