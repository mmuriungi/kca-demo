table 51048 Attachment2
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Table ID"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "AttachmentB"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SecondaryKey; "Table ID", "No.")
        {
            Clustered = false;
        }
    }
}
