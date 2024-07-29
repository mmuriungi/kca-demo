page 51108 "HRM-Appraisal Supervisors"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'Employee No.';
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                }
            }
            group("Department Allocations")
            {
                Caption = 'Department Allocations';
                part(Dept; "HRM-Appraisal Sup. Dept. Alloc")
                {
                    Caption = 'Department Setup';

                    SubPageLink = HOD = FIELD("No.");
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Lecturer := TRUE;
    end;

    var
        KPAObjectives: Record "HRM-KPA Objectives (B)";
        KPACode: Code[20];
        LecUnits: Record "HRM-HOD Dept. Loading";
        Vend: Record Vendor;
        gnLine: Record "Gen. Journal Line";
        GeneralSetup: Record "HRM-Appraisal Gen. Setup";
        GL: Record "G/L Entry";
}

