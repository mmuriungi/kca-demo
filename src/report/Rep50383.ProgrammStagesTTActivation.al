report 50383 "Programm Stages TT Activation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Programm Stages TT Activation.rdl';

    dataset
    {
        dataitem(DataItem1; "ACA-Programme Stages")
        {
            RequestFilterFields = "Programme Code", "Code";
            column(ProgrammeCode_ProgrammeStages; "Programme Code")
            {
            }
            column(Code_ProgrammeStages; Code)
            {
            }
            column(Description_ProgrammeStages; Description)
            {
            }
            column(Department_ProgrammeStages; Department)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF ActionX = ActionX::Include THEN
                    "Include in Time Table" := TRUE
                ELSE
                    "Include in Time Table" := FALSE;
                MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ActionX; ActionX)
                {
                    Caption = 'Action Type';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ActionX: Option Include,Clear;
}

