table 50068 "ACA-Reg. Stoppage Reasons"
{
    Caption = 'ACA-Reg. Stoppage Reasons';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            NotBlank = true;
        }
        field(2; "Reason Description"; Text[250])
        {
            Caption = 'Reason Description';
        }
        field(3; "Hide in Results"; Boolean)
        {
            Caption = 'Hide in Results';
        }
        field(4; "Pick Alternate Rubric"; Boolean)
        {
            Caption = 'Pick Alternate Rubric';
        }
        field(5; "Exclude Computation"; Boolean)
        {
            Caption = 'Exclude Computation';
        }
        field(6; "Change Global"; Boolean)
        {
            Caption = 'Change Global';
        }
        field(7; "Global Status"; Option)
        {
            Caption = 'Global Status';
            OptionMembers = Registration,Current,Alumni,"Dropped Out",Defered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate",Halt;
            OptionCaption = 'Registration,Current,Alumni,"Dropped Out",Defered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate",Halt';
        }
        field(8; "Move to Reservour"; Boolean)
        {
            Caption = 'Move to Reservour';
        }
        field(9; "Combine Discordant Semesters"; Boolean)
        {
            Caption = 'Combine Discordant Semesters';
        }
    }
    keys
    {
        key(PK; "Reason Code")
        {
            Clustered = true;
        }
    }
}
