tableextension 50033 "Document Attachment ext" extends "Document Attachment"
{
    fields
    {
        field(50001; "Sharepoint URL"; Text[300])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
    }
}