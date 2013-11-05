// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tsoy.pizzaroo.domain;

import com.tsoy.pizzaroo.domain.Base;
import com.tsoy.pizzaroo.domain.BaseDataOnDemand;
import com.tsoy.pizzaroo.domain.BaseIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect BaseIntegrationTest_Roo_IntegrationTest {
    
    declare @type: BaseIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: BaseIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: BaseIntegrationTest: @Transactional;
    
    @Autowired
    BaseDataOnDemand BaseIntegrationTest.dod;
    
    @Test
    public void BaseIntegrationTest.testCountBases() {
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", dod.getRandomBase());
        long count = Base.countBases();
        Assert.assertTrue("Counter for 'Base' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void BaseIntegrationTest.testFindBase() {
        Base obj = dod.getRandomBase();
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Base' failed to provide an identifier", id);
        obj = Base.findBase(id);
        Assert.assertNotNull("Find method for 'Base' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Base' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void BaseIntegrationTest.testFindAllBases() {
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", dod.getRandomBase());
        long count = Base.countBases();
        Assert.assertTrue("Too expensive to perform a find all test for 'Base', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Base> result = Base.findAllBases();
        Assert.assertNotNull("Find all method for 'Base' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Base' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void BaseIntegrationTest.testFindBaseEntries() {
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", dod.getRandomBase());
        long count = Base.countBases();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Base> result = Base.findBaseEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Base' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Base' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void BaseIntegrationTest.testFlush() {
        Base obj = dod.getRandomBase();
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Base' failed to provide an identifier", id);
        obj = Base.findBase(id);
        Assert.assertNotNull("Find method for 'Base' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyBase(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Base' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void BaseIntegrationTest.testMergeUpdate() {
        Base obj = dod.getRandomBase();
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Base' failed to provide an identifier", id);
        obj = Base.findBase(id);
        boolean modified =  dod.modifyBase(obj);
        Integer currentVersion = obj.getVersion();
        Base merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Base' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void BaseIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", dod.getRandomBase());
        Base obj = dod.getNewTransientBase(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Base' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Base' identifier to be null", obj.getId());
        try {
            obj.persist();
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        obj.flush();
        Assert.assertNotNull("Expected 'Base' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void BaseIntegrationTest.testRemove() {
        Base obj = dod.getRandomBase();
        Assert.assertNotNull("Data on demand for 'Base' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Base' failed to provide an identifier", id);
        obj = Base.findBase(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Base' with identifier '" + id + "'", Base.findBase(id));
    }
    
}
