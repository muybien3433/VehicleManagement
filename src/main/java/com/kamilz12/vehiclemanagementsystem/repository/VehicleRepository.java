package com.kamilz12.vehiclemanagementsystem.repository;

import com.kamilz12.vehiclemanagementsystem.model.vehicle.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface VehicleRepository extends JpaRepository<Vehicle,Integer> {
    Vehicle findByInternRestId(Integer internRestId);
    @Query("SELECT DISTINCT v.make FROM Vehicle v ORDER BY v.make ASC")
    List<String> findAllDistinctMakesASC();
    @Query("SELECT DISTINCT v.model FROM Vehicle v WHERE v.make = ?1 ORDER BY v.model ASC")
    List <String> findAllDistinctModelsByMake(String make);

    @Query("select DISTINCT v.year from Vehicle v where v.make=?1 and v.model=?2 order by v.year desc")
    List <Integer> findAllDistinctYearsByModelAndYear(String make, String model);

    @Query("select distinct v.engineName from Vehicle v where v.make=?1 and v.model=?2 and v.year=?3 order by v.engineName desc")
    List <String> findAllDistinctEnginesByMakeModelYear(String make, String model, Integer year);

    @Query("select distinct v.internRestId from Vehicle v where v.make=?1 and v.model=?2 and v.year=?3 and v.engineName=?4")
    Integer findDistinctInternRestIdByMakeModelYearEngineName(String make, String model,Integer year, String engine );







}
