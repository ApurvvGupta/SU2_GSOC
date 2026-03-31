import pysu2
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

driver = pysu2.CSinglezoneDriver("flatplate_varT.cfg", 1, comm)

marker_id = driver.GetMarkerIndices()["plate"]
n = driver.GetNumberMarkerNodes(marker_id)

for i in range(n):
    coords = driver.MarkerCoordinates(marker_id)
    x = coords(i,0)

    T = 300 + 500*(x + 0.0175)/(0.035)

    driver.SetMarkerCustomTemperature(marker_id, i, T)

driver.StartSolver()
driver.Finalize()