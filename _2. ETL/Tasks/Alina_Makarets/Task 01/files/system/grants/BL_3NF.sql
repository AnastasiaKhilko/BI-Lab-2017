EXEC grants_mgmt.grant_blat('CREATE ANY TABLE', 'BL_3NF');
EXEC grants_mgmt.grant_blat('SELECT ANY TABLE', 'BL_3NF');
--��� ������ ������ ������� ����� ������� ������� �������:
EXEC grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_continents','BL_3NF');
EXEC grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_countries','BL_3NF');
EXEC grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_world','BL_3NF');
EXEC grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_regions','BL_3NF');