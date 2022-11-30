round((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3, 2) AS tbnilai_nilaiakhir, 
(if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=85,'A', 
if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=70,'B', 
if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=55,'C', 
if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=40,'D','E'))))) AS tbnilai_nilaihuruf, 
(if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=55,'Lulus','Tidak Lulus')) AS tbnilai_status


ORDER BY 
tbmahasiswa.`semester` ASC, 
tbmahasiswa.`kelas` ASC, 
tbmahasiswa.`nama` ASC, 
tbmahasiswa.`nim` ASC