/// <summary>
/// Report Registry Files (ID 52178559).
/// </summary>
report 55102 "Registry Files"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Registry Files.rdl';
    Caption = 'Registry Files';

    dataset
    {
        dataitem(DataItem1; "REG-Registry Files")
        {
            column(folioNo; "File No.")
            {
            }
            column(File_Desc; "File Subject/Description")
            {
            }
            column(Issuing; "Issuing Officer")
            {
            }
            column(Return; "Expected Return Date")
            {
            }
            column(Reciving; "Receiving Officer")
            {
            }
            column(F_Status; FORMAT("File Status"))
            {
            }
            column(CareOf; "Care of")
            {
            }
            column(Type; FORMAT("File Type"))
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

